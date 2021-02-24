from django.conf.urls import url

from project.posts import views

urlpatterns = [
    url(
        r'^(?P<pk>[0-9]+)$',
        views.post,
        name='detail'
    ),
]
