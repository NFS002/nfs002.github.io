git add -A
git commit -m "updated theme"
git push origin sources
bundle exec jekyll build
echo "skydesign.blue" > _site/CNAME
push-dir --dir=_site --branch=maste