from django.conf.urls.defaults import patterns, include, url
from django.conf import settings
from django.conf.urls.static import static

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = []

urlpatterns += patterns('',
    url(r'^admin/', include(admin.site.urls)),
    (r'', include('moralcompass.core.urls')),
) + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)


