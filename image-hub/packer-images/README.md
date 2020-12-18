# Packer Images
This directory focuses on Packer images which pull an image from Vagrant to be used for testing
or production purposes. The supported builders (those that create machines or generate images) that Packer
supports are listed below:

NOTE: (I will be posting the more well-known builders since there are so many supported now. Here is a link
to ALL the builders Packer supports: https://www.packer.io/docs/builders)

- Amazon EC2
- Azure
- DigitalOcean
- Google Cloud
- Linode
- OpenStack
- Oracle
- Vagrant
- VirtualBox
- VMware

## Very Important Note
A very special thanks to Jeff Geerling for helping provide this open-source packer builds. If you get a chance, please visit his repostiory here: https://github.com/geerlingguy/packer-boxes. I modified his code for my needs and added several notations to allow readers a better understanding of the Packer code.