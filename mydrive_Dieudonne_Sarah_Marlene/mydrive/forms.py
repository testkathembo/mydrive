from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import AuthenticationForm
from .models import UploadedFile
from django.forms import ModelForm
from .models import Profile


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
    username = forms.CharField(max_length=150, widget=forms.TextInput(attrs={'autofocus': True}))
    password = forms.CharField(label="Password", widget=forms.PasswordInput)

from django.core.exceptions import ValidationError

class FileUploadForm(forms.ModelForm):
    class Meta:
        model = UploadedFile
        fields = ['file', 'name', 'original_location']

    def clean_file(self):
        file = self.cleaned_data.get('file')
        if file.size > 40 * 1024 * 1024:  # 40MB limit
            raise ValidationError("The file cannot be larger than 40MB.")
        return file

    

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


        
        

