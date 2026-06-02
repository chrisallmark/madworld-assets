# madworld-assets

Runtime audio and video assets for [madworld](https://github.com/chrisallmark/madworld).

## Structure

- `extras`: additional audio clips.
- `samples`: commentary samples.
- `tracks`: music tracks.
- `videos`: runtime video assets.
- `terraform`: S3 infrastructure for publishing these assets.

## AWS Configuration

In development mode the application uses local audio and video resources from this repository when it is checked out as a submodule at `public/assets`. In production mode audio and video resources are retrieved from AWS Simple Storage Service (S3).

To deploy the assets to AWS with [Terraform](https://developer.hashicorp.com/terraform), create a `terraform.tfvars` file in the `terraform` folder providing a list of allowed origins for CORS and a unique bucket name:

```
allowed_origins = ["*"]
bucket = "..."
```

From the `terraform` directory, provision the infrastructure with:

```
terraform init
terraform apply
```

Finally, configure the MadWorld application by declaring the following variables in the deployment environment:

```
AWS_ACCESS_KEY_ID = "..."
AWS_BUCKET = "..."
AWS_REGION = "..."
AWS_SECRET_ACCESS_KEY = "..."
```
