# Rough

To load Rough with `pry`

    $:.push File.expand_path("../lib", __FILE__)

    require 'rough'

Creating a new repo and adding README file

    repo = Rough::Repository.create("public/uploads/sites/site_id_or_name")

    repo.create_file('README.md', '# Rough')

    author = { email: 'testuser@github.com', name: 'Test Author'}

    repo.commit(author, 'Start the first rought site')

Fetching a existing repo and overriding the README file

    repo = Rough::Repository.fetch("public/uploads/sites/site_id_or_name")

    repo.create_file('README.md', "Rough\n===")

    author = { email: 'testuser@github.com', name: 'Test Author'}

    repo.commit(author, 'Update README of site')
