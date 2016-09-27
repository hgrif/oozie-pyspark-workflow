# Oozie & PySpark workflow

This project demonstrates a Oozie workflow with a PySpark action. It assumes that all the PySpark logic is in a Python library that only needs a `HiveContext` and a date to run. The Python library is distributed to all the workers on the cluster and a pipeline within the library is kicked off daily depending on some data sources.

A Oozie workflow with a PySpark action is non-trivial, because:

1. Oozie doesn't have native support for a PySpark action.
2. YARN can kill your Oozie container when running PySpark in a shell.
3. Distributing eggs with PySpark can be a challenge due to problems with the `PYTHON_EGG_CACHE` (depending on cluster setup).

Issue 1. is solved by calling `spark-submit` in a `shell-action`; 2. by setting the configuration in in the workflow definition; and 3. by setting the `PYTHON_EGG_CACHE` for the driver in the calling Python script and for the executors in the `spark-submit`.

Note: this repo will crash (and this time it's not Oozie's fault!): this is a stripped/anonymized version of a workflow. . Change references to namenodes, HDFS, Oozie urls, /user/-stuff, etc.


## Submitting a new workflow

Create a Python egg by cd-ing in Python project directory and copying it to `dist/` in the Oozie workflow folder:
```
$ cd python-project/
$ python setup.py bdist_egg
$ cp dist/project-1.0-py3.5.egg ../oozie-workflow/dist/
```

Run `update_and_run.sh` to upload `oozie-workflow/` to HDFS and run the Oozie coordinator.


## Folders


#### `oozie-workflow/`

Coordinator to run a workflow.

1. `job.properties`: Coordinator properties (start & end date, job tracker, etc.)
2. `coordinator.xml`: Coordinator setting data dependencies.
* `workflow.xml`: Workflow specification.
* `bin/`: Scripts used in the workflow.
* `dist/`: Folder with Python used in the workflow


#### `python-project/`

Python project. Project code in `pythonproject`, egg instructions in `setup.py`.
