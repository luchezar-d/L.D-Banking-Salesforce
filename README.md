# L.D Banking Salesforce Platform

Enterprise-grade Salesforce platform with AWS integration capabilities, featuring custom Apex classes, Lightning Web Components, and Connected Apps for seamless cloud integration.

## Project Overview

This project includes:
- **Custom Apex Classes** for business logic
- **Lightning Web Components** for modern UI
- **AWS Integration Hub** - Connected App for AWS services
- **Enterprise-grade architecture** and best practices

## Project Structure
- `force-app/` - Contains all Salesforce metadata including Apex classes, Lightning components, and configurations
- `manifest/` - Contains package.xml for deployment manifests
- `config/` - Project configuration files
- `scripts/` - Utility scripts for development

## Branches
- `main` - Production-ready code
- `dev` - Development branch for new features

## Development Workflow
1. Create feature branches from `dev`
2. Make changes and test locally
3. Submit pull request to merge into `dev`
4. After testing, merge `dev` into `main` for production deployment

## Deployment
Use the VS Code task "Deploy to Org" or run:
```bash
sf project deploy start --target-org MyDevOrg
```

## Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
