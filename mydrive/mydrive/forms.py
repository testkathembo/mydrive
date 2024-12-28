from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import AuthenticationForm
from .models import UploadedFile, Folder
from django.forms import ModelForm
from .models import Profile
from django.core.exceptions import ValidationError




class UserRegistrationForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    password_confirm = forms.CharField(widget=forms.PasswordInput)
    phone_number = forms.CharField(max_length=15, required=True, label="Phone Number")

    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'username', 'email', 'phone_number']
        widgets = {
            'first_name': forms.TextInput(attrs={'placeholder': 'ex: Kathembo'}),
            'last_name': forms.TextInput(attrs={'placeholder': 'ex: Tsongo'}),
            'username': forms.TextInput(attrs={'placeholder': 'ex: Dieudonne'}),
            'email': forms.EmailInput(attrs={'placeholder': 'address@gmail.com'}),
        }
        help_texts = {
            'username': '',
            'first_name': '',
            'last_name': '',
            'email': '',
            'phone_number': '',
        }

    def clean(self):
        cleaned_data = super().clean()
        password = cleaned_data.get('password')
        password_confirm = cleaned_data.get('password_confirm')

        if password and password_confirm and password != password_confirm:
            raise forms.ValidationError("Passwords do not match")

    def save(self, commit=True):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data['password'])
        if commit:
            user.save()
        return user

class UserLoginForm(AuthenticationForm):
    username = forms.CharField(
        max_length=150,
        widget=forms.TextInput(attrs={
            'class': 'form-control custom-input',
            'placeholder': 'Enter your username',
            'style': 'width: 50%;',
            'autofocus': True,
        }),
        label='Username'
    )
    password = forms.CharField(
        widget=forms.PasswordInput(attrs={
            'class': 'form-control custom-input',
            'placeholder': 'Enter your password',
            'style': 'width: 50%;',
        }),
        label="Password"
    )


class FileUploadForm(forms.ModelForm):
    folder = forms.ModelChoiceField(
        queryset=Folder.objects.all(),  # You can filter folders by user if necessary
        required=True,  # Ensure folder is a required field
        label="Select Folder",
        widget=forms.Select(attrs={"class": "form-control"}),
    )

    class Meta:
        model = UploadedFile
        fields = ('file', 'folder')  # Include 'folder' in the fields


    

class FileRenameForm(forms.ModelForm):
    class Meta:
        model = UploadedFile
        fields = ['name']  # Assuming 'name' is the field you want to change

class ProfileForm(ModelForm):
    class Meta:
        model = Profile
        fields = ['profile_picture']  # Include only fields that are in the Profile model


class ProfileUpdateForm(forms.ModelForm):
    first_name = forms.CharField(max_length=100, required=False)
    last_name = forms.CharField(max_length=100, required=False)
    email = forms.EmailField(required=False)

    class Meta:
        model = Profile
        fields = ['profile_picture']

    def save(self, *args, **kwargs):
        user = self.instance.user
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        user.email = self.cleaned_data['email']
        user.save()
        return super().save(*args, **kwargs)




        
        

