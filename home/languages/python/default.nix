{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (python3.withPackages (
      python-packages: with python-packages; [
        graphviz
        html2text
        hypothesis
        matplotlib
        numpy
        openpyxl
        pandas
        pygments
        python-lsp-server
        scikit-learn
        scipy
        xlsxwriter
        yattag
        z3
      ]
    ))
  ];
}
