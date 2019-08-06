# -*- coding: utf-8 -*-
from flask import Flask
import os
app = Flask(__name__)
if 'ROOT_PATH' in os.environ:
    app.config['APPLICATION_ROOT'] = os.environ['ROOT_PATH']
import pytree.views

# Load point cloud at server startup
# pointcloud = pytree_init.loadPointCloud('./pytree/resources/pointclouds/ca13_sub/cloud.js')
print("starting pytree server...")
