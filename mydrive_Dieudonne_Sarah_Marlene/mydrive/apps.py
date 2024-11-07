    
from django.apps import AppConfig

class MydriveConfig(AppConfig):
    name = 'mydrive'

    def ready(self):
        import mydrive.signals

