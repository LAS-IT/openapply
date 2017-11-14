module SpecData

  STATUS_APPLIED_ARRAY_EMPTY =
    [
      ["student_id"],
    ]

  STATUS_APPLIED_ARRAY_KIDS_EMPTY =
    [
      ["student_id", "student_name"],
    ]

  STATUS_APPLIED_ARRAY_KIDS_RENTS_EMPTY =
    [
      [ "student_id", "student_name",
        "guardian1_id", "guardian1_name",
        "guardian2_id", "guardian2_name",
      ],
    ]

  STATUS_APPLIED_ARRAY_KIDS_PAY_EMPTY =
    [
      [ "student_id", "student_name",
        "payment1_invoice_number", "payment1_amount",
        "payment2_invoice_number", "payment2_amount",
      ],
    ]

  STATUS_APPLIED_ARRAY_KIDS_KEYS_EMPTY =
    [
      [ "student_id",
        "guardian1_id", "guardian1_name",
        "guardian2_id", "guardian2_name",
        "payment1_invoice_number", "payment1_amount",
        "payment2_invoice_number", "payment2_amount",
      ],
    ]

  STATUS_APPLIED_ARRAY_POPULATED_KIDS =
    [
      ["student_id", "student_name"],
      [95, "Richard Washington"],
      [106, "Samuel Epelbaum"],
      [240, "Jesse Hawkins"],
      [267, "John Jean"],
      [268, "Lucille Austero"],
      [269, "Aishia Babatunde"],
      [270, "Fatuma Katlego"],
      [271, "Beatriz Santos"],
    ]

  STATUS_APPLIED_ARRAY_POPULATED_KIDS_1_GUARDIAN =
    [
      [ "student_id", "student_name", "guardian1_id", "guardian1_name"],
      [95, "Richard Washington", 492, "Philippa Washington"],
      [106, "Samuel Epelbaum", 265, "Thomas Epelbaum"],
      [240, "Jesse Hawkins", 408, "Sabrina Hawkins"],
      [267, "John Jean", 504, "Cosette Jean"],
      [268, "Lucille Austero", 506, "Stan Austero"],
      [269, "Aishia Babatunde", 507, "Habib Babatunde"],
      [270, "Fatuma Katlego", 509, "Duma Katlego"],
      [271, "Beatriz Santos", 510, "Rafael Santos"],
    ]

  STATUS_APPLIED_ARRAY_POPULATED_KIDS_2_GUARDIANS =
    [
      [ "student_id", "student_name", "guardian1_id", "guardian1_name", "guardian2_id", "guardian2_name"],
      [95, "Richard Washington", 492, "Philippa Washington", 493, "Fred Washington"],
      [106, "Samuel Epelbaum", 265, "Thomas Epelbaum", 266, "Ann Epelbaum"],
      [240, "Jesse Hawkins", 408, "Sabrina Hawkins", 409, "Jeramy Hawkins"],
      [267, "John Jean", 504, "Cosette Jean", 505, "Marius Jean"],
      [268, "Lucille Austero", 506, "Stan Austero", nil, nil],
      [269, "Aishia Babatunde", 507, "Habib Babatunde", 508, "Hawa Babatunde" ],
      [270, "Fatuma Katlego", 509, "Duma Katlego", nil, nil],
      [271, "Beatriz Santos", 510, "Rafael Santos", 511, "Ana Clara Santos"],
    ]

  STATUS_APPLIED_ARRAY_POPULATED_KIDS_GUARDIANS_PAYMENTS =
    [
      [ "student_id", "student_name", "guardian1_id", "guardian1_name",
        "guardian2_id", "guardian2_name", "payment1_invoice_number",
        "payment1_amount", "payment2_invoice_number", "payment2_amount",
      ],
      [95, "Richard Washington"],
      [106, "Samuel Epelbaum"],
      [240, "Jesse Hawkins"],
      [267, "John Jean"],
      [268, "Lucille Austero"],
      [269, "Aishia Babatunde"],
      [270, "Fatuma Katlego"],
      [271, "Beatriz Santos"],
    ]
end
