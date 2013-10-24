See http://extensions.behat.org/jira-extension/ for more information regarding the extension module.

To run all tests in the project JIRA tickets:

  sudo behat https://ikosltd.atlassian.net/

to run a single test

  sudo behat https://ikosltd.atlassian.net/browse/<ticket id>

where <ticket id> is the JIRA ticket identifier eg. QMS-123

The test runs in test mode by default and thus the JIRA tickets will not be updated.
However, you can use the -p parameter to select update mode:

  sudo behat -p update https://ikosltd.atlassian.net/  


