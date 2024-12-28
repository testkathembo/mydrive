from django.db import models
from django.contrib.auth.models import User
import os

class Folder(models.Model):
    name = models.CharField(max_length=255)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class UploadedFile(models.Model):
    name = models.CharField(max_length=255, blank=True, null=True)
    file = models.FileField(upload_to='uploads/')
    folder = models.ForeignKey(Folder, on_delete=models.CASCADE, related_name='files')  # Link file to a folder
    owner = models.ForeignKey(User, on_delete=models.CASCADE, related_name='uploaded_files')
    last_modified = models.DateTimeField(auto_now=True)
    file_size = models.PositiveIntegerField(blank=True, null=True)
    original_location = models.CharField(max_length=255, blank=True, null=True)

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

    def __str__(self):
        return f"{self.name} ({self.folder.name})"

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    profile_picture = models.ImageField(upload_to='profile_pics/', null=True, blank=True)

    class Meta:
        db_table = 'mydrive_profile'

    def __str__(self):
        return f"{self.user.username}'s profile"
