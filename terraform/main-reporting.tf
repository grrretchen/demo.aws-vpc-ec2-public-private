resource "aws_resourceexplorer2_view" "example" {
  name = var.project_name

  filters {
    filter_string = format(
      "tag:Project=%s region:%s",
      var.project_name,
      var.aws_region
    )
  }

  included_property {
    name = "tags"
  }
}