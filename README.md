# Simplify Azure Machine Learning Ops

# Infrastructure

![Initial Infra](https://microsoft.github.io/azureml-ops-accelerator/3-Deploy/azure-machine-learning-terraform/media/architecture_aml_pl.png)

In this infrastructure, the machine learning workspace have the moderate sercure with custom virtual network. Initial, the infra include:
<ul>
    <li>The Machine Learning workspace to ML/DS team for deverlop machine learning model</li>
    <ul>
        <li>The AppInsigh for monitoring</li>
        <li>The keyvault to store sensitive informations </li>
        <li>The storage account to store the requirement data </li>
        <li>Compute instance to deverlop model </li>
    </ul>
    <li>AKS for deploy the core app </li>
    <ul>
        <li>Deploy the simple webapp </li>
        <li>Integrate the trained model </li>
    </ul>
    <li>Jumphost VM for retricting access </li>
</ul>
