Feature: --format json
  As a user
  I want to be able to get all output in JSON format
  So I can easily parse the output in scripts

  Scenario: JSON output installing a cookbook from the default location
    Given I write to "Berksfile" with:
      """
      cookbook "mysql", "1.2.4"
      """
    When I run the install command with flags:
      | --format json |
    Then the output should contain JSON:
      """
      {
        "cookbooks": [
          {
            "version": "1.2.4",
            "name": "mysql"
            "location": "site: 'http://cookbooks.opscode.com/api/v1/cookbooks'",
          },
          {
            "name": "openssl"
            "version": "1.0.2",
            "location": "site: 'http://cookbooks.opscode.com/api/v1/cookbooks'",
          }
        ],
        "errors": [

        ],
        "messages": [

        ]
      }
      """

  Scenario: JSON output installing a cookbook we already have
    Given the cookbook store has the cookbooks:
      | mysql   | 1.2.4 |
    And I write to "Berksfile" with:
      """
      cookbook "mysql", "1.2.4"
      """
    When I run the install command with flags:
      | --format json |
    Then the output should contain JSON:
      """
      {
        "cookbooks": [
          {
            "version": "1.2.4",
            "name": "mysql"
          }
        ],
        "errors": [

        ],
        "messages": [

        ]
      }
      """

  @chef_server
  Scenario: JSON output when running the upload command
    Given a Berksfile with path location sources to fixtures:
      | example_cookbook | example_cookbook-0.5.0 |
    And the Chef server does not have the cookbooks:
      | example_cookbook | 0.5.0 |
    When I run the upload command with flags:
      | --format json |
    Then the output should contain exactly:
      """
      foo
      """
