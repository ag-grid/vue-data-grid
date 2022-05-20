cat pdf-metadata.md > vue-tutorial.md
cat newpage.md >> vue-tutorial.md
cat 00a-introduction.md >> vue-tutorial.md

cat newpage.md >> vue-tutorial.md
cat 001-quickstart-vue-ag-grid.md >> vue-tutorial.md

cat newpage.md >> vue-tutorial.md
cat 002-enable-enterprise.md >> vue-tutorial.md

cat newpage.md >> vue-tutorial.md
cat 003-vue-cell-renderers.md >> vue-tutorial.md

cat newpage.md >> vue-tutorial.md
cat 999-outro.md >> vue-tutorial.md

pandoc vue-tutorial.md -o vue-tutorial-workbook.pdf --from markdown --template eisvogel --listings --toc
open vue-tutorial-workbook.pdf