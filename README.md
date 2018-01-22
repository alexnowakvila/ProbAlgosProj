# PROBABILISTIC ALGORITHMS FOR CONSTRUCTING MATRIX DECOMPOSITIONS
This project was done for the course [Sparsity and Compressed Sensing](http://www.gpeyre.com/teaching/) of the 
master [Mathématiques, Vision et Apprentissage](http://math.ens-paris-saclay.fr/version-francaise/formations/master-mva/) at [École Normale Supérieure de Cachan](http://www.ens-cachan.fr/) taught by [G. Peyré](http://www.gpeyre.com/).
## Abstract
Low-rank matrix approximations are obliquous in many areas ranging from data analysis
to scientific computing. From a data science point of view, probably the most important application
is due to Principal Component Analysis (PCA), which aims to reveal hidden linear structure in mas-
sive datasets through a low-rank matrix decomposition. Consequently, the complexity of the algorithm
plays a central role in the applicability of the algorithms to big data. The most common approximative
factorization is the so-called truncated singular value decomposition (k-SVD) which can be computed
in O(mnk) floating-point operations, where k is the target rank of the decomposition and m and n
are the corresponding dimensions of the matrix. In this review, we introduce to the reader randomized
algorithms that can achieve the aforementioned task with numerous advantadges compared to the clas-
sical algorithms. These randomized methods are based on the fact that the image of a low-rank matrix
can be approximated by the action of the matrix to a reasonable amount of random vectors from the
input space. Starting from this point, it is possible to develop algorithms that achieve a complexity of
O(mn log(k)) for dense-matrices, matches the flop count of classical Krylov subspace methods for sparse
matrices with a gain in robustness, and for large matrices that can not be stored in memory (RAM),
they achieve a constant number of passes compared to the O(k) for classical algorithms.

## References
- [Finding structure in randomness](http://users.cms.caltech.edu/~jtropp/papers/HMT11-Finding-Structure-SIREV.pdf)
- [Complementary](https://arxiv.org/pdf/1606.06511v1.pdf)

## Experiments
Experiments are implemented in Matlab.
### Experiment 1: On powers of Gaussian Matrices
Run:
```
experiment1
```
### Experiment 2: On MNIST Dataset
Run:
```
experiment2
```
### Experiment 3: Laplacian Image
Run:
```
experiment3
```
