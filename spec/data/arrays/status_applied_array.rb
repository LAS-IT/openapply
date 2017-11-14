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
