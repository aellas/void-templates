# void-templates

A personal collection I've found of templates for building packages I use on Void Linux.  

## Getting Started

Before using these templates, make sure you’ve set up your local `void-packages` repo. Follow the official guide here:  
👉 [void-linux/void-packages](https://github.com/void-linux/void-packages)

Once you're set up, simply move any template from this repo into your `void-packages/srcpkgs` directory.

## Example

```sh
cp -r my-template ~/void-packages/srcpkgs/
cd ~/void-packages
./xbps-src pkg my-template