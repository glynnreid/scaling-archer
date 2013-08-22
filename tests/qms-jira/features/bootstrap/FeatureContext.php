<?php

use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;

use Behat\MinkExtension\Context\MinkContext;

//
// Require 3rd-party libraries here:
//
//   require_once 'PHPUnit/Autoload.php';
//   require_once 'PHPUnit/Framework/Assert/Functions.php';
//

use Behat\Mink\Exception\UnsupportedDriverActionException,
    Behat\Mink\Exception\ExpectationException;
use Behat\MinkBundle\Driver\SymfonyDriver;

use PHPUnit_Framework_ExpectationFailedException as AssertException;


use Drupal\DrupalExtension\Context\DrupalContext,
    Drupal\DrupalExtension\Event\EntityEvent;

/**
 * Features context.
 */
class FeatureContext extends DrupalContext
{
    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     *
     * @param array $parameters context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        // Initialize your context here
    }

    public function getSymfonyProfile()
        {
            $driver = $this->getSession()->getDriver();
            if (!$driver instanceof SymfonyDriver) {
                throw new UnsupportedDriverActionException(
                    'You need to tag the scenario with '.
                    '"@mink:symfony". Using the profiler is not '.
                    'supported by %s', $driver
                );
            }

            $profile = $driver->getClient()->getProfile();
            if (false === $profile) {
                throw new \RuntimeException(
                    'Emails cannot be tested as the profiler is '.
                    'disabled.'
                );
            }

            return $profile;
        }

  /**
     * @When /^I Agree$/
     */
    public function iAgree()
    {
        $session = $this->getSession();
        $session->setCookie("cookie-agreed-en","2");
    }

    /**
         * @When /^I wait for a minute$/
         */
        public function iWaitForAMinute()
        {
            $this->getSession()->wait(60000);
        }

        /**
         * @When /^I wait for a moment$/
         */
        public function iWaitForAMoment()
        {
            $this->getSession()->wait(5000);
        }

        /**
         * @Given /^I should get an email on "(?P<email>[^"]+)" with:$/
         */
        public function iShouldGetAnEmail($email, PyStringNode $text)
        {
            $error     = sprintf('No message sent to "%s"', $email);
            $profile   = $this->getSymfonyProfile();
            $collector = $profile->getCollector('swiftmailer');

            foreach ($collector->getMessages() as $message) {
                // Checking the recipient email and the X-Swift-To
                // header to handle the RedirectingPlugin.
                // If the recipient is not the expected one, check
                // the next mail.
                $correctRecipient = array_key_exists(
                    $email, $message->getTo()
                );
                $headers = $message->getHeaders();
                $correctXToHeader = false;
                if ($headers->has('X-Swift-To')) {
                    $correctXToHeader = array_key_exists($email,
                        $headers->get('X-Swift-To')->getFieldBodyModel()
                    );
                }

                if (!$correctRecipient && !$correctXToHeader) {
                    continue;
                }

                try {
                    // checking the content
                    return assertContains(
                        $text->getRaw(), $message->getBody()
                    );
                } catch (AssertException $e) {
                    $error = sprintf(
                        'An email has been found for "%s" but without '.
                        'the text "%s".', $email, $text->getRaw()
                    );
                }
            }

            throw new ExpectationException($error, $this->getSession());
        }

        /**
         * @Given /^I click on the view payment link$/
         */
        public function iClickOnTheViewPaymentLink()
        {
            $session = $this->getSession();
            $page = $session->getPage();
            $view_link = $page->find('css', '.commerce-payment-transaction-view a');
            $view_link->click();
        }

        /**
         *  @Given /^I click edit on the first order$/
         */
        public function iClickEditOnTheFirstOrder()
        {
                $session = $this->getSession();
                $page = $session->getPage();
                $edit_link = $page->find('css', 'tr.views-row-first td.views-field-php a:nth-child(2)');
                if (!$edit_link) throw new Exception("No edit link available for the first order");
                $edit_link->click();

        }

        /**
         *  @Given /^I click edit on the first order in the admin view$/
         */
        public function iClickEditOnTheFirstOrderInTheAdminView()
        {
                $session = $this->getSession();
                $page = $session->getPage();
                $edit_link = $page->find('css', '.views-row-first .commerce-order-edit a');
                if (!$edit_link) throw new Exception("No edit link available for the first order");
                $edit_link->click();

        }

        /**
         * @Then /^there should be no edit link$/
         */
        public function thereShouldBeNoEditLink()
        {
            $session = $this->getSession();
            $page = $session->getPage();
            $edit_link = $page->find('css', 'tr.views-row-first td.views-field-php a:nth-child(2)');
            if ($edit_link) throw new Exception("Edit link is present.");

        }

        /**
         * @Then /^there should be no cancel link$/
         */
        public function thereShouldBeNoCancelLink()
        {
            $session = $this->getSession();
            $page = $session->getPage();
            $cancel_link = $page->find('css', 'tr.views-row-first td.views-field-php a:nth-child(1)');
            if ($cancel_link) throw new Exception("Cancel link is present.");

        }

        /**
         * @When /^I click cancel on the first order$/
         */
        public function whenIClickCancelOnTheFirstOrder()
        {
            $session = $this->getSession();
            $page = $session->getPage();
            $cancel_link = $page->find('css', 'tr.views-row-first td.views-field-php a:nth-child(1)');
            if (!$cancel_link) throw new Exception("Cancel link is not present.");
            $cancel_link->click();

        }

        /**
         * @Then /^I want to validate select option "([^"]*)" default is "([^"]*)"$/
         */
        public function iWantToValidateSelectOptionDefaultIs($locator, $defaultValue) {
             $optionElement = $this->getSession()->getPage()->find('xpath', '//select[@name="' . $locator . '"]/option[@selected]');
             if (!$optionElement) {
                throw new Exception('select option has not found default value for ' . $locator);
             }

            $selectedDefaultValue = (string)$optionElement->getText();
             if ($selectedDefaultValue != $defaultValue) {
                throw new Exception('select option default value: "' . $selectedDefaultValue . '" does not match given: "' . $defaultValue . '"');
             }
        }


            /**
             * @Then /^the current order status should be "([^"]*)"$/
             */
            public function theCurrentOrderStatusShouldBe($status)
            {
                $locator = "status";
                $optionElement = $this->getSession()->getPage()->find('xpath', '//select[@name="' . $locator . '"]/optgroup/option[@selected]');
                if (!$optionElement) {
                   throw new Exception('no current status is set');
                }

               $selectedDefaultValue = (string)$optionElement->getText();
                if ($selectedDefaultValue != $status) {
                   throw new Exception('current order status: "' . $selectedDefaultValue . '" does not match expected: "' . $status . '"');
                }

            }

    /**
     * @Given /^I go to the payment page for the first order$/
     */
    public function iGoToThePaymentPageForTheFirstOrder()
    {
       $session = $this->getSession();
       $page = $session->getPage();
       $order_id_cell = $page->find('css', 'tr.views-row-first .views-field-order-number');
       $order_id = trim($order_id_cell->getValue());
       $session->visit('admin/commerce/orders/' . $order_id . '/payment');
    }

  /**
     * @Then /^the order balance should be "([^"]*)"$/
     */
    public function theOrderBalanceShouldBe($balance)
    {
        $session = $this->getSession();
       $page = $session->getPage();
       $balance_cell = $page->find('css', 'td.balance');
       if ($balance_cell->getValue() != $balance) throw new Exception ("Balance was not the expected value");
      }

    /**
     * @Then /^the payment remote status should be "([^"]*)"$/
     */
    public function thePaymentRemoteStatusShouldBe($status)
    {
         $session = $this->getSession();
       $page = $session->getPage();
       $status_cell = $page->find('css', '.payment-transaction tr:nth-child(8) td:nth-child(2)');
       if ($status_cell->getValue() != $status) throw new Exception ("Status was not the expected value");
    }

    /**
     * @Given /^the payment status should be "([^"]*)"$/
     */
    public function thePaymentStatusShouldBe($status)
    {
     $session = $this->getSession();
       $page = $session->getPage();
       $status_cell = $page->find('css', '.payment-transaction tr:nth-child(7) td:nth-child(2)');
       if ($status_cell->getValue() != $status) throw new Exception ("Status was not the expected value");

    }

/**
     * @Given /^I select the "([^"]*)" radio button$/
     */
    public function iSelectTheRadioButton($radio_label) {
      $radio_button = $this->getSession()->getPage()->findField($radio_label);
      if (null === $radio_button) {
        throw new ElementNotFoundException(
          $this->getSession(), 'form field', 'id|name|label|value', $field
        );
      }
      //$value = $radio_button->getAttribute('value');
      //$this->fillField($radio_label, $value);
    }

    /**
        * @Given /^I select the iframe$/
        */
       public function iSelectTheIframe()
       {
           $driver = $this->getSession()->getDriver();
           $driver->switchToIFrame("iframe_3d_secure");

       }
    /**
     * @Given /^I press submit in the (\d+)d secure form$/
     */
    public function iPressSubmitInTheDSecureForm($arg1)
    {
    $session = $this->getSession();
        $page = $session->getPage();
        $submit_button = $page->find('css', 'input[type="submit"]');
        $submit_button->press();
    }

}
