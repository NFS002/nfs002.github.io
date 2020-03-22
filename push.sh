cd ~/skydesign
git checkout sources
bundle exec jekyll build
git add -A
git commit -m "updated theme"
git push origin sourcesç