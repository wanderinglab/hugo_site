
# Covid Hugo

[![Netlify Status](https://api.netlify.com/api/v1/badges/4c903640-00f4-4086-9b55-5b2c60f89bfc/deploy-status)](https://app.netlify.com/sites/ecstatic-kirch-e1f78c/deploys)

## Getting Started

### Step 0: Pre recs

#### Git

You're here, so I think its safe to assume you've got
this taken care of.

#### Docker

Make sure you have docker installed.  
([Here's a guide just in case](https://www.docker.com/get-started))

### Step 1: Clone Repo  

In Hugo, themes added to projects using git submodules.
Don't worry if you haven't used these, this is the only
step where they'll matter for most in this project.

```bash
# Clone Repo
git clone --recursive https://github.com/CovidDS-SMU/covid-hugo.git  
# Move into repo
cd covid-hugo
```

### Step 2: Change Branch

**[this still needs to be worked out. we cannot
start bad habit of everyone working on master branch.
There should only be merge commmits on master.]**

### Step 3: Spin Up Local Version

```bash
# Assuming project directory is your cwd
# Render site without drafts (how site will look live, online)
make server

# Render site with drafts (preferred when working on unfinished posts/changes/projects)
make server args="Dw"
```

### Step 4: Done

Thats it. The site should be visible at
<http://localhost:1313>. Any changes made while site server is running will trigger an autoreload so don't worry
about hammering that refresh button.

## Resources/Requirements

### Tools that helped develop this project

- <https://deloreanipsum.com/>
- <http://nietzsche-ipsum.com/>
- <https://www.freecodecamp.org/news/a-portable-makefile-for-continuous-delivery-with-hugo-and-github-pages/>
- <https://www.netlify.com/>
- <https://gohugo.io/>
- [https://hub.docker.com/r/klakegg/hugo](https://hub.docker.com/r/klakegg/hugo)