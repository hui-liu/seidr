.. _genie3-label:

GENIE3
======

GENIE3 calculates a Random Forest regression using genes as predictors. It then
uses Random Forests importance measures as gene association scores. The method
is described in [Huynh-Thu2010]_ . Internally, our implementation uses ranger
to calculate the forests and importance [Wright2017]_ .

Running GENIE3
^^^^^^^^^^^^^^

GENIE3 needs a minimum of two input files:

* ``-i, --infile``: An expression matrix (genes are columns, samples are rows) without headers.
* ``-g, --genes``: A file containing gene names that correspond to columns in the expression matrix.

Here is an example matrix containing expression data for five genes in ten samples::

    0.4254475 0.0178292 0.9079888 0.4482474 0.1723238
    0.4424002 0.0505248 0.8693676 0.4458513 0.1733112
    1.0568470 0.2084539 0.4674478 0.5050774 0.2448833
    1.1172264 0.0030010 0.3176543 0.3872039 0.2537921
    0.9710677 0.0010565 0.3546514 0.4745322 0.2077183
    1.1393856 0.1220468 0.4024654 0.3484362 0.1686139
    1.0648694 0.1405077 0.4817628 0.4748571 0.1826433
    0.8761173 0.0738140 1.0582917 0.7303661 0.0536562
    1.2059661 0.1534070 0.7608608 0.6558457 0.1577311
    1.0006755 0.0789863 0.8036309 0.8389751 0.0883061

In the genes files, we provide the column headers for the expression matrix *in order*::

    G1
    G2
    G3
    G4
    G5

With that, we can run GENIE3::

    genie3 -i expr_mat.tsv -g genes.txt

The output is a square matrix of scores::

    0   0.108322    0.264794    0.0692147   0.0482803
    0.00914761  0   0.00844504  0.00974063  0.00616896
    0.167265    0.0721168   0   0.0914891   0.180078
    0.0163077   0.0211425   0.0369387   0   0.0932622
    0.00277062  0.00334468  0.00934115  0.0114427   0


Optional arguments for GENIE3
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* ``-s, --scale``: This triggers `feature scaling <https://en.wikipedia.org/wiki/Feature_scaling#Standardization>`_ of the expression matrix before the regression calculation. Generally this should be *off*.
* ``-b, --ntree``: Grow this many trees for each gene.
* ``-m, --mtry``: Sample this many features (genes) for each tree.
* ``-p, --min-prop``: Lower quantile of covariate distribution to be considered for splitting.
* ``-a, --alpha``: Significance threshold to allow splitting.
* ``-N, --min-node-size``: Minimum node size

Running GENIE3 for a subset of genes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Often we have only a small number of genes of interest. We can instruct 
GENIE3 to only calculate interactions involving those genes by 
providing a ``-t, --targets`` file containing these gene names::

    G3
    G4

And running it with the ``-t, --targets`` options::

    genie3 -i expr_mat.tsv -g genes.txt -t targets.txt

In this case we will receive an edge list as output::

    G3  G1  0.167265
    G3  G2  0.0721168
    G3  G4  0.0914891
    G3  G5  0.180078
    G4  G1  0.0163077
    G4  G2  0.0211425
    G4  G3  0.0369387
    G4  G5  0.0932622

Running GENIE3 in MPI mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

GENIE3 can use parallel processing. For general info
on how to run parallel algorithms in ``seidr``, please see :ref:`mpirun-label`
