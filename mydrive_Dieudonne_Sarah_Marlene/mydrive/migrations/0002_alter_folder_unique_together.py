# Generated by Django 5.1 on 2024-11-03 07:00

from django.conf import settings
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('mydrive', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='folder',
            unique_together={('owner', 'parent_folder', 'name')},
        ),
    ]
