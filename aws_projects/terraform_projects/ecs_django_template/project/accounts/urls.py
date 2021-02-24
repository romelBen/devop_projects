from django.conf.urls import url

from project.accounts import views

urlpatterns = [
    url(r'^signup/$', views.signup, name='signup'),
]
