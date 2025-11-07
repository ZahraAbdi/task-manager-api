
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import  task_stats
from django.urls import path
from .views import TaskListCreateView, TaskDetailView
from django.contrib import admin



router = DefaultRouter()

##  This automatically creates a set of RESTful endpoints TaskViewSet
# router.register(r'tasks', TaskViewSet, basename='task')

urlpatterns = [
    #path('', include(router.urls)),
    path('tasks/', TaskListCreateView.as_view(), name='task-list'),
    path('tasks/<int:pk>/', TaskDetailView.as_view(), name='task-detail'),
    path('tasks/stats/', task_stats, name='task-stats'),  # stats endpoint
]

