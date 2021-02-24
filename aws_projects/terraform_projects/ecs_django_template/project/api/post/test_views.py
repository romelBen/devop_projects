from __future__ import unicode_literals

from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from rest_framework.status import HTTP_200_OK, HTTP_403_FORBIDDEN
from rest_framework.status import HTTP_201_CREATED
from rest_framework.status import HTTP_204_NO_CONTENT
from rest_framework.test import APITestCase

from project.posts.models import Post


class PostCreateTests(APITestCase):
    def setUp(self):
        self.url = reverse('api:post-list')
        self.data = {
            'message': 'Hello world.',
        }

    def test_create_anonymous(self):
        response = self.client.post(self.url, data=self.data, format='json')
        self.assertEqual(response.status_code, HTTP_403_FORBIDDEN)

    def test_create(self):
        test_user = User.objects.create_user(
            username='test_user',
            first_name='Bob',
            last_name='User',
            email='bob@example.com',
        )
        self.client.force_authenticate(user=test_user)
        response = self.client.post(self.url, data=self.data, format='json')
        self.assertEqual(response.status_code, HTTP_201_CREATED)
        posts = Post.objects.all()
        post = posts.last()
        self.assertEqual(posts.count(), 1)
        self.assertEqual(post.author, test_user)
        self.assertEqual(post.message, self.data['message'])
        self.assertIsNotNone(post.date_created)
        self.assertIsNone(post.date_deleted)
        self.assertIsNone(post.parent)


class PostDeleteTests(APITestCase):
    def setUp(self):
        self.test_user = User.objects.create_user(
            username='test_user',
            first_name='Bob',
            last_name='User',
            email='bob@example.com',
        )
        self.post = Post.objects.create(
            author=self.test_user,
            message='Hello world.',
        )
        self.url = reverse(
            'api:post-detail',
            kwargs={'pk': self.post.pk},
        )

    def test_delete_anonymous(self):
        response = self.client.delete(self.url)
        self.assertEqual(response.status_code, HTTP_403_FORBIDDEN)
        self.assertEqual(Post.objects.count(), 1)
        self.assertIsNone(Post.objects.last().date_deleted)

    def test_delete(self):
        self.client.force_authenticate(user=self.test_user)
        response = self.client.delete(self.url)
        self.assertEqual(response.status_code, HTTP_204_NO_CONTENT)
        self.assertEqual(Post.objects.count(), 1)
        self.assertIsNotNone(Post.objects.last().date_deleted)


class PostGetTests(APITestCase):
    def setUp(self):
        self.test_user = User.objects.create_user(
            username='test_user',
            first_name='Bob',
            last_name='User',
            email='bob@example.com',
        )
        self.post = Post.objects.create(
            author=self.test_user,
            message='Hello world.',
        )
        self.url = reverse(
            'api:post-detail',
            kwargs={'pk': self.post.pk},
        )

    def test_get(self):
        response = self.client.get(self.url, format='json')
        self.assertEqual(response.status_code, HTTP_200_OK)
        self.assertIsNotNone(response.data.pop('date_created'))
        self.assertEqual(
            response.data,
            {
                'author': self.test_user.pk,
                'message': 'Hello world.',
                'parent': None,
            }
        )


class PostListTests(APITestCase):
    def setUp(self):
        self.test_user = User.objects.create_user(
            username='test_user',
            first_name='Bob',
            last_name='User',
            email='bob@example.com',
        )
        self.post1 = Post.objects.create(
            author=self.test_user,
            message='Hello world 1.',
        )
        self.post2 = Post.objects.create(
            author=self.test_user,
            message='Hello world 2.',
        )
        self.url = reverse('api:post-list')

    def test_get(self):
        response = self.client.get(self.url, format='json')
        self.assertEqual(response.status_code, HTTP_200_OK)
        dates_created = [data.pop('date_created') for data in response.data]
        self.assertTrue(all(dates_created))
        self.assertEqual(
            response.data,
            [
                {
                    'author': self.test_user.pk,
                    'message': 'Hello world 2.',
                    'parent': None,
                },
                {
                    'author': self.test_user.pk,
                    'message': 'Hello world 1.',
                    'parent': None,
                },
            ]
        )

