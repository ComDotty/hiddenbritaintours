import 'https://cdn.jsdelivr.net/gh/orestbida/cookieconsent@3.0.1/dist/cookieconsent.umd.js';

CookieConsent.run({
    guiOptions: {
        consentModal: {
            layout: "bar inline",
            position: "bottom",
            equalWeightButtons: true,
            flipButtons: false
        },
        preferencesModal: {
            layout: "box",
            position: "right",
            equalWeightButtons: true,
            flipButtons: false
        }
    },

    onFirstConsent: function() {
        if (CookieConsent.acceptedCategory('necessary')) {
        }
    },

    onConsent: function(cookie) {
        if (CookieConsent.acceptedCategory('analytics')) {
            updateConsent(true);
        } else {
            updateConsent(false);
        }
    },

    onChange: function({ changedCategories }) {
        if (changedCategories.includes('analytics')) {
            if (CookieConsent.acceptedCategory('analytics')) {
                 updateConsent(true);
            } else {
                updateConsent(false);
            }
        }
    },

    categories: {
        necessary: {
            enabled: true,  // this category is enabled by default
            readOnly: true  // this category cannot be disabled
        },

        analytics: {
            enabled: false,  // this category is disabled by default
            autoClear: {
                cookies: [
                    {
                        name: /^_ga/,   // regex: match all cookies starting with '_ga'
                    },
                    {
                        name: '_gid',   // string: exact cookie name
                    }
                ]
            }
        }
    },

    language: {
        default: "en",
        autoDetect: "browser",
        translations: {
            en: {
                consentModal: {
                    title: "This site uses cookies",
                    description: "We collect cookies to analyze our website traffic and control targeted advertising. Some are essential while others are used to ensure you get the best browsing experience. Once set you can change your cookie preferences from the <a href=\"https://www.hiddenbritaintours.co.uk/pages/privacy.html\" target=\"_blank\">Privacy Policy</a> page",
                    acceptAllBtn: "Accept all",
                    acceptNecessaryBtn: "Reject all",
                    showPreferencesBtn: "Manage cookie preferences",
                    footer: "<a href=\"https://www.hiddenbritaintours.co.uk/pages/privacy.html\" target=\"_blank\">Privacy Policy</a>\n<a href=\"https://www.hiddenbritaintours.co.uk/pages/tandc.html\" target=\"_blank\">Terms and conditions</a>"
                },
                preferencesModal: {
                    title: "Manage cookie preferences",
                    acceptAllBtn: "Accept all",
                    acceptNecessaryBtn: "Reject all",
                    savePreferencesBtn: "Save preferences",
                    closeIconLabel: "Close",
                    serviceCounterLabel: "Service|Services",
                    sections: [
                        {
                            title: "Cookie Usage",
                            description: "Cookies are used for functionality and allow users to interact with a service or site to access features that are fundamental to that service. Things considered fundamental to the service include preferences like the user’s choice of language, product optimizations that help maintain and improve a service, and maintaining information relating to a user’s session, such as the content of a shopping cart."
                        },
                        {
                            title: "Strictly Necessary Cookies <span class=\"pm__badge\">Always Enabled</span>",
                            description: "Strictly Necessary Cookies are those that enable a website to function, without them the website might not work properly or might not work at all.",
                            linkedCategory: "necessary"
                        },
                        {
                            title: "Consent Mode V2 - Analytics Cookies",
                            description: "Analytics Cookies help collect data that allows services to understand how users interact with a particular service. These insights allow services both to improve content and to build better features that improve the user’s experience.",
                            linkedCategory: "analytics",
                            cookieTable: {
                                headers: {
                                    name: "Name",
                                    domain: "Service",
                                    description: "Description",
                                    expiration: "Expiration"
                                },
                                body: [
                                    {
                                        name: "_ga",
                                        domain: "Google Analytics",
                                        description: "Cookie set by <a href=\"#das\">Google Analytics</a>",
                                        expiration: "Expires after 90 days"
                                    },
                                    {
                                        name: "_gid",
                                        domain: "Google Analytics",
                                        description: "Cookie set by <a href=\"#das\">Google Analytics</a>",
                                        expiration: "End of Session"
                                    }
                                ]
                            }
                        },
                        {
                            title: "More information",
                            description: "For any query in relation to our policy on cookies and your choices, please <a class=\"cc__link\" href=\"https://www.hiddenbritaintours.co.uk/pages/contact.html\" target=\"_blank\">contact us</a>."
                        }
                    ]
                }
            }
        }
    }
});

function updateConsent(isAnalyticsEnabled) {
    if (isAnalyticsEnabled) {
        gtag('consent', 'update', {
            'ad_storage': 'granted',
            'analytics_storage': 'granted',
            'ad_user_data': 'granted',
            'ad_personalization': 'granted'
        });
    } else {
        gtag('consent', 'update', {
            'ad_storage': 'denied',
            'analytics_storage': 'denied',
            'ad_user_data': 'denied',
            'ad_personalization': 'denied'
        });
    }
}
