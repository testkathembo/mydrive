from django.urls import path, include
from . import views
from django.conf import settings
from django.conf.urls.static import static
from .views import (register, login_view, 
                    logout_view, home_view, 
                    upload_file_view, move_file, 
                    copy_file, share_file, 
                    create_folder_view,
                    storage_distribution_view,
                    storage_view,
                    profile_view,
                                                        
)
from django.contrib.auth import views as auth_views  # Import Django's built-in views



urlpatterns = [
    path('register/', register, name='register'),
    path('login/', login_view, name='login'),
    path('logout/', logout_view, name='logout'),
    path('home/', home_view, name='home'),  # Correct path for the home view
    path('search/', views.search_drive, name='search_drive'),
    path('upload/', views.upload_file_view, name='upload_file'),
    path('download/<int:file_id>/', views.download_file, name='download_file'),
    path('delete/<int:file_id>/', views.delete_file, name='delete'),
    path('move/<int:file_id>/', views.move_file, name='move_file'),
    path('copy/<int:file_id>/', views.copy_file, name='copy_file'),
    path('share-file/<int:file_id>/', views.share_file, name='share_file'),  
    path('storage_distribution/', views.storage_distribution_view, name='storage_distribution'),
    path('storage/', storage_view, name='storage'),
    path('create-folder/', views.create_folder_view, name='create_folder'), 
    path('delete-folder/<int:folder_id>/', views.delete_folder, name='delete_folder'),
    path('folder/<int:folder_id>/', views.open_folder, name='open_folder'),
    path('profile/', views.profile_view, name='profile'),
    # Password reset
    path('password_reset/', views.password_reset_request, name='password_reset'),
    path('password_reset/done/', auth_views.PasswordResetDoneView.as_view(template_name='password_reset_done.html'), name='password_reset_done'),
    path('reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(template_name='password_reset_confirm.html'), name='password_reset_confirm'),
    path('reset/done/', auth_views.PasswordResetCompleteView.as_view(template_name='password_reset_complete.html'), name='password_reset_complete'),


] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

    



    





   
