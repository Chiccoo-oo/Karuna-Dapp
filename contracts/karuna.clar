(define-map projects
  uint
  {
    name: (string-ascii 100),
    description: (string-ascii 256),
    goal: uint,
    raised: uint,
  }
)

;; A map to store a log of every donation.
;; The key is a unique donation ID, and the value is a tuple containing donor, amount, and project ID.
(define-map donations
  uint
  {
    donor: principal,
    amount: uint,
    project-id: uint,
  }
)

;; A data variable to keep track of the next available project ID.
(define-data-var next-project-id uint u0)

;; A data variable to keep track of the next available donation ID.
(define-data-var next-donation-id uint u0)

;; --- Admin address for project creation ---
;; Replace the dummy address below with your actual Stacks Testnet address.
(define-constant admin-address 'ST23XZVZF6A2XSG4SJ05XT24ENQ88P3G1KCAWTP5K)

;; --- Public Functions (Callable by anyone) ---

;; create-project
;; Creates a new charity project. This function can only be called by a designated admin.
(define-public (create-project
    (project-name (string-ascii 100))
    (project-description (string-ascii 256))
    (project-goal uint)
  )
  (begin
    (asserts! (is-eq tx-sender admin-address) (err u100))

    (let ((id (var-get next-project-id)))
      (map-set projects id {
        name: project-name,
        description: project-description,
        goal: project-goal,
        raised: u0,
      })
      (var-set next-project-id (+ id u1))
      (ok id)
    )
  )
)

;; donate
;; Allows a user to donate STX to a specific project.
(define-public (donate
    (project-id uint)
    (amount uint)
  )
  (begin
    (let ((project (map-get? projects project-id)))
      (asserts! (is-some project) (err u101))
      (let ((current-raised (get raised (unwrap-panic project))))
        ;; The `stx-transfer?` function sends the STX from the donor to the admin wallet.
        (try! (stx-transfer? amount tx-sender admin-address))

        ;; Update the total raised amount for the project.
        (map-set projects project-id
          (merge (unwrap-panic project) { raised: (+ current-raised amount) })
        )

        ;; Log the donation for transparency.
        (let ((donation-id (var-get next-donation-id)))
          (map-set donations donation-id {
            donor: tx-sender,
            amount: amount,
            project-id: project-id,
          })
          (var-set next-donation-id (+ donation-id u1))
          (ok true)
        )
      )
    )
  )
)

;; --- Read-Only Functions (Viewable by anyone) ---

;; get-project-details
;; Returns the details of a specific project.
(define-read-only (get-project-details (project-id uint))
  (ok (map-get? projects project-id))
)
