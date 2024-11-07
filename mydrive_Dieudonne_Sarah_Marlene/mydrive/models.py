from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
import os
from django.db.models.signals import post_save
from django.dispatch import receiver

class UploadedFile(models.Model):
    name = models.CharField(max_length=255, blank=True, null=True)
    owner = models.ForeignKey(User, on_delete=models.CASCADE, related_name='uploaded_files')
    last_modified = models.DateTimeField(auto_now=True)
    file_size = models.PositiveIntegerField(blank=True, null=True)
    original_location = models.CharField(max_length=255, blank=True, null=True)
    file = models.FileField(upload_to='uploads/')

    def file_type(self):
        _, extension = os.path.splitext(self.file.name)
        if extension.lower() in ['.jpg', '.jpeg', '.png', '.gif']:
            return 'Image'
        elif extension.lower() in ['.pdf', '.doc', '.docx', '.txt']:
            return 'Document'
        elif extension.lower() in ['.mp4', '.avi', '.mov']:
            return 'Video'
        else:
            return 'Other'

    def save(self, *args, **kwargs):
        if not self.name:
            self.name = os.path.basename(self.file.name)
        if self.file:
            self.file_size = self.file.size
            self.original_location = self.file.name
        super(UploadedFile, self).save(*args, **kwargs)

    @staticmethod
    def get_storage_usage(user):
        user_files = UploadedFile.objects.filter(owner=user)
        return sum(file.file_size for file in user_files if file.file_size)

class Folder(models.Model):
    name = models.CharField(max_length=255)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    profile_picture = models.ImageField(upload_to='profile_pics/', null=True, blank=True)

    class Meta:
        db_table = 'mydrive_profile'

    def __str__(self):
        return f"{self.user.username}'s profile"

    
    
    
