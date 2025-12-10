import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    // Define the targets that the controller will use
    static targets = ["companyInput", "newCompanyFields", "status"]

    // A property to hold the debounce timeout
    checkTimeout = null

    // The 'check' method is called on 'input' event (as defined in the view's action)
    check() {
        // Clear any previous timeout
        clearTimeout(this.checkTimeout)

        // Set a new timeout to call _checkCompanyExists after 500ms
        this.checkTimeout = setTimeout(() => {
            this._checkCompanyExists(this.companyInputTarget.value.trim())
        }, 500)
    }

    // The core logic to check the company's existence via API
    async _checkCompanyExists(companyName) {
        if (companyName.length < 2) {
            this._hideCompanyFields()
            this.statusTarget.style.display = 'none'
            return
        }

        try {
            const response = await fetch(`/companies/check_exists?name=${encodeURIComponent(companyName)}`)
            const data = await response.json()

            this.statusTarget.style.display = 'block'

            if (data.exists) {
                // Company exists - hide additional fields
                this._hideCompanyFields()
                this.statusTarget.textContent = '✓ This company already exists in our system'
                this.statusTarget.style.color = 'green'
            } else {
                // Company doesn't exist - show additional fields
                this._showCompanyFields()
                this.statusTarget.textContent = 'This appears to be a new company. Please provide additional details.'
                this.statusTarget.style.color = 'blue'
            }
        } catch (error) {
            console.error('Error checking company:', error)
            // On error, assume it's a new company to be safe
            this._showCompanyFields()
        }
    }

    _showCompanyFields() {
        this.newCompanyFieldsTarget.style.display = 'block'
    }

    _hideCompanyFields() {
        this.newCompanyFieldsTarget.style.display = 'none'
    }

    // Called when the controller is connected (when the page loads or Turbo renders the element)
    connect() {
        this._hideCompanyFields()
    }
}