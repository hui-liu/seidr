.. _narromi-label:

NARROMI
=======

Narromi is an MI based algorithm that tries to minimize noise in the MI using
linear programming. It is published in [Zhang2013]_ .

Running Narromi
^^^^^^^^^^^^^^^

Narromi needs a minimum of two input files:

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

With that, we can run Narromi::

    narromi -i expr_mat.tsv -g genes.txt

The output is a square matrix of scores::

    0   0   0.581267    0.00822935  0.0106747
    0.100319    0   0.00249005  0.0137571   9.62593e-05
    0.116941    0.00249005  0   0.624368    0
    0.00822935  0.0137571   0.50236 0   0
    0.0106747   9.62593e-05 0.29456 0.199657    0


Optional arguments for Narromi
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* ``-a, --alpha``: Initial cutoff for MI selection (alpha).
* ``-m, --algorithm``: Linear programming algorithm. Interior point is probably faster, but can be unstable for some datasets. When in doubt, choose simplex.

Running Narromi for a subset of genes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Often we have only a small number of genes of interest. We can instruct 
Narromi to only calculate interactions involving those genes by 
providing a ``-t, --targets`` file containing these gene names::

    G3
    G4

And running it with the ``-t, --targets`` options::

    narromi -i expr_mat.tsv -g genes.txt -t targets.txt

In this case we will receive an edge list as output::

    G3  G1  0.116941
    G3  G2  0.00249005
    G3  G4  0.624368
    G3  G5  0
    G4  G1  0.00822935
    G4  G2  0.0137571
    G4  G3  0.50236
    G4  G5  0

Running Narromi in MPI mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Narromi can use parallel processing. For general info
on how to run parallel algorithms in ``seidr``, please see :ref:`mpirun-label`
