from setuptools import setup, find_packages

setup(
    name='project',

    version='1.0',

    description='Python Project',

    author='Henk Griffioen',

    packages=find_packages(exclude=['bin', 'notebooks']),

    # In case you're adding model files to your package, may make people angry.
    package_data={
        'project': ['models/dummy.pickle'],
    },
)

# More info on data files:
# https://www.metabrite.com/devblog/posts/including-data-files-in-python-packages/
# https://setuptools.readthedocs.io/en/latest/setuptools.html#including-data-files
