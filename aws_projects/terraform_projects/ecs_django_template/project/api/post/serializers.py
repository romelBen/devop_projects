import random
import time

from django.contrib.auth.models import User
from rest_framework import serializers

from project.posts.models import Like
from project.posts.models import Post


class LikeSerializer(serializers.ModelSerializer):
    post = serializers.PrimaryKeyRelatedField(
        queryset=Post.objects.all(),
        required=False,
    )
    user = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        required=False,
    )

    class Meta:
        model = Like
        fields = [
            'user',
            'post',
        ]

    def save(self, **kwargs):
        self._mock_do_work()

        return super(LikeSerializer, self).save(**kwargs)

    def _mock_do_work(self):
        """
        Note to candidate: DO NOT TOUCH THIS METHOD, it is an abstraction
        for real world performance issues
        """
        a = random.randint(6, 31)
        time.sleep(a)
        

class PostSerializer(serializers.ModelSerializer):
    author = serializers.PrimaryKeyRelatedField(
        queryset=Post.objects.all(),
        required=False,
    )
    # def __init__(self, *args, **kwargs):
    #     print('IN INIT')
    #     print('Args', args)
    #     print('Kwargs', kwargs)
    #     data = kwargs.get('data', None)
    #     print('Data', data)
    #     if data:
    #         if 'author' not in data:
    #             data['author'] = getattr(self.context, 'request', None)

    #     super(PostSerializer, self).__init__(*args, **kwargs)

    class Meta:
        model = Post
        fields = [
            'author',
            'message',
            'date_created',
            'parent',
        ]
