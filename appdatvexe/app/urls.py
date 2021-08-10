from django.urls import path, include
from . import views
from .admin import admin_site
from rest_framework.routers import DefaultRouter


router = DefaultRouter()
router.register('points', views.PointViewSet)
router.register('users', views.UserViewSet)
router.register('lines', views.LineViewSet)
router.register('trips', views.TripViewSet)
router.register('tickets', views.TicketViewSet)
router.register('feedbacks', views.FeedbackViewSet)

urlpatterns = [
    path('admin/', admin_site.urls),
    path('', include(router.urls)),
]