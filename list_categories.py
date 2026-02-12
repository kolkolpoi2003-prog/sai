import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
django.setup()

from shop.models import Category

print("--- CATEGORIES START ---")
for c in Category.objects.all():
    print(f"Name: {c.name}")
    print(f"Slug: {c.slug}")
    print(f"Active: {c.is_active}")
    print("-" * 20)
print("--- CATEGORIES END ---")
