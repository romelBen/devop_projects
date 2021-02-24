"""project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""

import project.api.urls
import project.posts.urls
import django.contrib.auth.urls
import project.accounts.urls

from django.conf.urls import include
from django.conf.urls import url
from django.contrib import admin

from project import views


urlpatterns = [
    url(r'^$', views.index),
    url(r'^api/', include('project.api.urls', namespace='api')),
    url(r'^posts/', include('project.posts.urls', namespace='posts')),
    url(r'^admin/', admin.site.urls),
    url(
        r'^accounts/',
        include('django.contrib.auth.urls', namespace='accounts')
    ),
    url(
        r'^accounts/',
        include('project.accounts.urls', namespace='accounts_custom')
    ),
]
