from rest_framework import routers

from project.api.post.views import PostViewSet

router = routers.DefaultRouter()
router.register(r'post', PostViewSet, basename='post')
urlpatterns = router.urls
