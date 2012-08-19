from django.conf.urls.defaults import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

from .views import Home

urlpatterns = patterns('moralcompass.core.views',
    url(r'^$', Home.as_view(), name='home'),
)
