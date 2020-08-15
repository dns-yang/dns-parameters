# DNS Parameters

YANG modules with types representing various DNS-related parameters.

Modules that mirror IANA registries are generated from the current contents of each registry by using a corresponding XSLT stylesheet from the [xslt](https://github.com/dns-yang/dns-parameters/tree/master/xslt) directory. The included [Makefile](https://github.com/dns-yang/dns-parameters/blob/master/Makefile) automates these transformations. After running `make`, the following YANG modules will be present:

* _iana-dns-class-rr-type_: [DNS CLASSes and RR TYPEs](https://www.iana.org/assignments/dns-parameters)
* _dns-yang-tsig-algorithms_: [TSIG Algorithm Names](https://www.iana.org/assignments/tsig-algorithm-names)

The generated modules can also be syntactically validated using

``` shell
$ make validate
```

## Prerequisites

* [curl](https://curl.haxx.se/)
* [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html)
* GitHub project [yin-tools](https://github.com/llhotka/yin-tools) – the local directory where this project is cloned should be specified in the [Makefile](https://github.com/dns-yang/dns-parameters/blob/master/Makefile) (variable `YINTOOLS`).
* [Jing](https://relaxng.org/jclark/jing.html) – for module validation
