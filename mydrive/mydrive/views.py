from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, authenticate, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .forms import (UserRegistrationForm, UserLoginForm, FileUploadForm,)
from django.contrib.auth.models import User
from .models import UploadedFile, Folder 
from django.http import HttpResponse
from django.http import FileResponse
import os
from django.db.models import Case, When, Value, CharField, Count
from django.db.models import Sum
from django.core.mail import send_mail
from django.conf import settings
from .models import Profile
from .forms import ProfileUpdateForm

from django.contrib.auth.forms import PasswordResetForm
from django.contrib.auth.tokens import default_token_generator
from django.utils.http import urlsafe_base64_encode
from django.utils.encoding import force_bytes
from django.template.loader import render_to_string




def register(request):
    """Handles user registration."""
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            messages.success(request, 'Registration successful! You can now log in.')
            return redirect('login')
    else:
        form = UserRegistrationForm()
    
    return render(request, 'register.html', {'form': form})

def login_view(request):
    """Handles user login."""
    if request.method == 'POST':
        form = UserLoginForm(data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(request, username=username, password=password)

            if user is not None:
                login(request, user)
                return redirect('home')
            else:
                messages.error(request, 'Invalid username or password.')
    else:
        form = UserLoginForm()

    return render(request, 'login.html', {'form': form})


def logout_view(request):
    """Logs out the user and redirects to the login page."""
    logout(request)
    messages.success(request, 'Logged out successfully.')
    return redirect('login')

from django.contrib.auth.forms import PasswordResetForm
from django.contrib.auth.tokens import default_token_generator
from django.utils.http import urlsafe_base64_encode
from django.utils.encoding import force_bytes
from django.template.loader import render_to_string
from django.contrib.auth.models import User
from django.core.mail import EmailMessage
from django.contrib import messages

def password_reset_request(request):
    if request.method == "POST":
        form = PasswordResetForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            users = User.objects.filter(email=email)
            if users.exists():
                for user in users:
                    context = {
                        'email': user.email,
                        'domain': request.get_host(),
                        'site_name': 'Your Site Name',
                        'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                        'user': user,
                        'token': default_token_generator.make_token(user),
                        'protocol': 'http',  # Use 'https' in production
                    }
                    subject = "Password Reset Requested"
                    email_template_name = "password_reset_email.html"
                    email_content = render_to_string(email_template_name, context)
                    email_message = EmailMessage(subject, email_content, to=[user.email])
                    email_message.send()
                messages.success(request, 'Password reset email sent.')
                return redirect('password_reset_done')
            else:
                messages.error(request, 'No account found with this email.')
    else:
        form = PasswordResetForm()
    return render(request, "password_reset_form.html", {"form": form})

@login_required
def home_view(request):
    # Fetch all files for the current user or all files if admin
    files = UploadedFile.objects.all() if request.user.is_superuser else UploadedFile.objects.filter(owner=request.user)
    
    # Fetch all folders for the current user
    folders = Folder.objects.filter(owner=request.user)
    
    # Prepare the full name of the user
    full_name = f"{request.user.first_name} {request.user.last_name}"
    
    # Pass it along with other context data to the template
    context = {
        'files': files,
        'folders': folders,  # Pass folders to the template
        'name': full_name  # Passing user's full name to the template
    }
    return render(request, 'home.html', context)


@login_required
def search_drive(request):
    query = request.GET.get('q', '')
    results = UploadedFile.objects.filter(name__icontains=query, owner=request.user) if query else []
    return render(request, 'search_results.html', {'results': results, 'query': query})

@login_required
def upload_file_view(request):
    if request.method == 'POST':
        form = FileUploadForm(request.POST, request.FILES)
        folder_id = request.POST.get('folder_id')  # Get folder ID from the form

        if not folder_id:  # Check if folder_id is missing
            messages.error(request, "Please select a folder.")
            return redirect('upload_file')  # Redirect to upload form
        
        try:
            folder = Folder.objects.get(id=folder_id, owner=request.user)  # Ensure folder belongs to the user
        except Folder.DoesNotExist:
            messages.error(request, "The selected folder does not exist.")
            return redirect('upload_file')

        if form.is_valid():
            file_instance = form.save(commit=False)
            file_instance.owner = request.user
            file_instance.folder = folder  # Assign the selected folder
            file_instance.save()
            messages.success(request, "File uploaded successfully!")
            return redirect('home')  # Redirect to home or desired view
        else:
            messages.error(request, "Failed to upload file. Please check the form.")
            return render(request, 'upload_file.html', {'form': form})

    else:
        form = FileUploadForm()
        folders = Folder.objects.filter(owner=request.user)  # Fetch folders for dropdown
        return render(request, 'upload_file.html', {'form': form, 'folders': folders})

   


def delete_file(request, file_id):
    file = get_object_or_404(UploadedFile, pk=file_id)
    file.delete()
    messages.success(request, "File deleted successfully.")
    return redirect('home')    



def download_file(request, file_id):
    file_instance = get_object_or_404(UploadedFile, id=file_id)
    return FileResponse(file_instance.file.open(), as_attachment=True, filename=file_instance.name)


@login_required
def upload_file_view(request):
    if request.method == 'POST':
        form = FileUploadForm(request.POST, request.FILES)
        if form.is_valid():
            file_instance = form.save(commit=False)
            current_usage = get_storage_usage(request.user)
            projected_usage = current_usage + file_instance.file.size

            if projected_usage > 100 * 1024 * 1024:  # 100MB limit
                messages.error(request, 'Exceeds total storage limit of 100MB.')
                return render(request, 'upload_file.html', {'form': form})

            file_instance.owner = request.user
            file_instance.save()
            messages.success(request, 'File uploaded successfully!')
            return redirect('home')
        else:
            messages.error(request, 'Upload failed. Please check the form.')
    else:
        form = FileUploadForm()
    return render(request, 'upload_file.html', {'form': form})


@login_required
def create_folder_view(request):
    if request.method == 'POST':
        folder_name = request.POST.get('folder_name')
        if folder_name:
            # Logic to create the folder
            # Assuming Folder is a model that stores folder information
            Folder.objects.create(name=folder_name, owner=request.user)
            return redirect('some_success_url')  # Redirect after successful creation
        else:
            return render(request, 'some_template.html', {'error': 'Folder name is required'})

    return render(request, 'create_folder.html')  # Show the form to create a folder


@login_required
def copy_file(request, file_id):
    # Fetch the file to be copied
    file = get_object_or_404(UploadedFile, pk=file_id, owner=request.user)

    # Get the folder of the file being copied
    folder = file.folder

    # Create a new copy of the file
    new_file = UploadedFile.objects.create(
        name=f"Copy of {file.name}",  # Prefix the name
        file=file.file,  # Use the same file
        owner=request.user,  # Assign the same owner
        folder=folder,  # Ensure the folder is copied
    )

    new_file.save()  # Save the new file instance
    messages.success(request, "File copied successfully.")
    return redirect('home')

@login_required
def move_file(request, file_id):
    # Fetch the file to be moved
    file = get_object_or_404(UploadedFile, pk=file_id, owner=request.user)

    # Get all folders owned by the user
    folders = Folder.objects.filter(owner=request.user)

    if request.method == 'POST':
        # Fetch the target folder ID from the POST request
        target_folder_id = request.POST.get('target_folder')
        target_folder = get_object_or_404(Folder, id=target_folder_id, owner=request.user)

        # Move the file to the new folder
        file.folder = target_folder
        file.save()

        # Display a success message and redirect
        messages.success(request, f"File '{file.name}' moved successfully to folder '{target_folder.name}'.")
        return redirect('home')

    # Render the move file template
    return render(request, 'move_file.html', {'file': file, 'folders': folders})

def send_test_email(request, recipient_email, file):
    subject = 'File Shared with You'
    download_link = request.build_absolute_uri(file.file.url)
    message = f'The file {file.file.name} has been shared with you. You can download it here: {download_link}'
    from_email = settings.EMAIL_HOST_USER

    try:
        send_mail(
            subject,
            message,
            from_email,
            [recipient_email],
            fail_silently=False,
        )
        print(f"Email sent to {recipient_email}")
    except Exception as e:
        print(f"An error occurred: {str(e)}")

@login_required
def share_file(request, file_id):
    file = get_object_or_404(UploadedFile, id=file_id)

    if request.method == "POST":
        email = request.POST.get('email')
        send_test_email(request, email, file)
        messages.success(request, 'File shared successfully!')
        return redirect('home')

    return render(request, 'share_file.html', {'file': file})


@login_required
def storage_distribution_view(request):
    # Use the logged-in user's ID to filter files
    owner_id = request.user.id

    file_types = UploadedFile.objects.filter(owner_id=owner_id).annotate(
        file_type=Case(
            When(file__endswith='.jpg', then=Value('Image')),
            When(file__endswith='.jpeg', then=Value('Image')),
            When(file__endswith='.png', then=Value('Image')),
            When(file__endswith='.gif', then=Value('Image')),
            When(file__endswith='.pdf', then=Value('Document')),
            When(file__endswith='.doc', then=Value('Document')),
            When(file__endswith='.docx', then=Value('Document')),
            When(file__endswith='.txt', then=Value('Document')),
            When(file__endswith='.mp4', then=Value('Video')),
            When(file__endswith='.avi', then=Value('Video')),
            When(file__endswith='.mov', then=Value('Video')),
            default=Value('Other'),
            output_field=CharField(),
        )
    ).values('file_type').annotate(count=Count('id')).order_by('file_type')

    colors = {
        'Image': '#FF6384',
        'Document': '#36A2EB',
        'Video': '#FFCE56',
        'Other': '#E7E9ED'
    }

    file_type_colors = [colors.get(ft['file_type'], '#E7E9ED') for ft in file_types]

    context = {
        'file_types': list(file_types),
        'file_type_colors': file_type_colors,
    }
    return render(request, 'storage_distribution.html', context)


def get_storage_usage(user):
    user_files = UploadedFile.objects.filter(owner=user)
    total_size = user_files.aggregate(total=Sum('file_size'))['total'] or 0
    return total_size

@login_required
def storage_view(request):
    total_storage = 100 * 1024 * 1024  # 100MB
    used_storage = get_storage_usage(request.user)
    free_storage = total_storage - used_storage

    # Pass data to the template
    context = {
        'used_storage': used_storage,
        'free_storage': free_storage,
        'total_storage': total_storage,
    }
    return render(request, 'storage.html', context)

@login_required
def create_folder_view(request):
    if request.method == 'POST':
        folder_name = request.POST.get('folder_name', '').strip()
        if folder_name:
            # Assuming Folder model has a name field and an owner field
            Folder.objects.create(name=folder_name, owner=request.user)
            messages.success(request, "Folder created successfully!")
            return redirect('home')  # Redirect to a page where the user can see their folders
        else:
            messages.error(request, "Folder name cannot be empty.")
            return render(request, 'create_folder.html', {'error': "Folder name cannot be empty."})
    else:
        return render(request, 'create_folder.html')

@login_required
def delete_folder(request, folder_id):
    folder = get_object_or_404(Folder, pk=folder_id, owner=request.user)  # Only allow deletion of user's own folders
    folder.delete()
    messages.success(request, "Folder deleted successfully.")
    return redirect('home')

@login_required
def open_folder(request, folder_id):
    # Fetch the folder being opened
    folder = get_object_or_404(Folder, id=folder_id, owner=request.user)
    
    # Fetch only files related to the current folder
    files = UploadedFile.objects.filter(folder=folder)  # Filter files by folder

    # Fetch any subfolders related to the current folder (if needed)
    subfolders = Folder.objects.filter(owner=request.user, id=folder_id)  # Adjust if subfolders are nested

    return render(request, 'folder_contents.html', {
        'folder': folder,
        'files': files,
        'subfolders': subfolders,
    })


@login_required
def profile_view(request):
    if request.method == 'POST':
        form = ProfileUpdateForm(request.POST, request.FILES, instance=request.user.profile)
        if form.is_valid():
            form.save()
            messages.success(request, 'Profile updated successfully!')
            return redirect('home')  # Ensure this redirects to a URL name that resolves
        else:
            messages.error(request, 'Please correct the error below.')
    else:
        form = ProfileUpdateForm(instance=request.user.profile)

    context = {'form': form}
    return render(request, 'profile.html', context)

