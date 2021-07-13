git add -A
git commit -m "some update"
git push origin sources
bundle exec jekyll build
push-dir --dir=_site --branch=master