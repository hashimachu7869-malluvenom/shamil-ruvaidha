#!/usr/bin/env python3
from PIL import Image, ImageEnhance

# Path to the image
img_path = r'assets\bg-forest.png'

# Load image
img = Image.open(img_path)

# Increase contrast by +20 (1.0 is original, 1.2 is +20% increase)
enhancer = ImageEnhance.Contrast(img)
enhanced_img = enhancer.enhance(1.2)

# Save back to the same location
enhanced_img.save(img_path)
print('Contrast increased by +20 for bg-forest.png')
