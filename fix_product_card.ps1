$content = @"
{% load static humanize %}
<!-- Product Card Component (Premium) -->
<div class="product-card group relative flex flex-col h-full" {% if delay %}style="transition-delay: {{ delay }}ms;"{% endif %}>
    <!-- Image Container -->
    <div class="relative overflow-hidden bg-[#f5f5f5] aspect-[3/4] mb-4">
        {% if product.main_image %}
        <img src="{{ product.main_image.image.url }}" alt="{{ product.main_image.alt|default:product.name }}"
            class="w-full h-full object-cover object-center group-hover:scale-105 transition-transform duration-[0.8s] ease-out"
            loading="lazy">
        {% else %}
        <div class="w-full h-full flex items-center justify-center text-gray-300">
            <svg class="w-12 h-12" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                    d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
            </svg>
        </div>
        {% endif %}

        <!-- Minimalist Badges -->
        <div class="absolute top-0 left-0 p-3 flex flex-col gap-1 z-10">
            {% if product.is_on_sale %}
            <span class="px-2 py-1 bg-[#1a1a1a] text-white text-[10px] font-bold uppercase tracking-widest">-{{ product.discount_percent|floatformat:0 }}%</span>
            {% endif %}
            {% if product.is_new %}
            <span class="px-2 py-1 bg-white/90 backdrop-blur-sm text-black text-[10px] font-bold uppercase tracking-widest">New</span>
            {% endif %}
        </div>

        <!-- Wishlist (Hidden until hover) -->
        {% if user.is_authenticated %}
        <button
            class="wishlist-btn absolute top-3 right-3 w-8 h-8 flex items-center justify-center text-[#1a1a1a] opacity-0 group-hover:opacity-100 transition-opacity duration-300 hover:text-[#5a6b47]"
            data-product-id="{{ product.id }}">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                    d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
            </svg>
        </button>
        {% endif %}

        <!-- Quick Add (Bottom overlay) -->
        <button
            class="absolute bottom-0 left-0 w-full bg-[#1a1a1a] text-white py-3 text-[10px] font-bold uppercase tracking-[0.2em] translate-y-full group-hover:translate-y-0 transition-transform duration-300"
            data-product-id="{{ product.id }}" {% if not product.is_available %}disabled{% endif %}>
            {% if product.is_available %}
            В корзину
            {% else %}
            Нет в наличии
            {% endif %}
        </button>
    </div>

    <!-- Info -->
    <div class="flex flex-col flex-grow">
        {% if product.brand %}
        <p class="text-[10px] text-gray-400 font-bold uppercase tracking-widest mb-1">{{ product.brand.name }}</p>
        {% endif %}
        <a href="{{ product.get_absolute_url }}" class="block group-hover:text-[#5a6b47] transition-colors mb-1">
            <h3 class="text-sm font-medium text-[#1a1a1a] leading-tight font-heading">{{ product.name }}</h3>
        </a>

        <!-- Price -->
        <div class="mt-auto pt-2 flex items-baseline gap-2">
            <span class="text-sm font-semibold text-[#1a1a1a]">{{ product.price|floatformat:0|intcomma }} ₽</span>
            {% if product.old_price %}
            <span class="text-xs text-gray-400 line-through">{{ product.old_price|floatformat:0|intcomma }} ₽</span>
            {% endif %}
        </div>
    </div>
</div>
"@
Set-Content -Path "c:\Users\mira\Desktop\sai1.2\templates\includes\product_card.html" -Value $content -Encoding UTF8
Write-Host "File written successfully."
