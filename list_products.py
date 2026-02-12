import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
django.setup()

from shop.models import Product

products = Product.objects.all()
for p in products:
    images_count = p.images.count()
    print(f"ID: {p.id} | Name: {p.name} | Images: {images_count}")
