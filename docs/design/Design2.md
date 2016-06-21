# Numbers (App, design doc)

## Data format

```elm
type Report = Report
  { id : Int
  , date : Date
  , members : List Member
  , assignments : Dict Member (List Family)
  , visits : Dict Family (List Visit)
  , attendance : Dict Member Bool
  , announcements : String
  , companionships : List Companionship
  }

type alias Name = String
type alias District = Int
type Member = Member Name
type Family = Family Name
type Visit = Family Month Year
type Companionship = Companionship
  { id : Int
  , district : Int
  , teachers : List Member
  , families : List Family
  }
```

## Pages :

 - Roll (Allows reporting only, not viewing of current.)
 - Behind Login
   - Quarterly Attendance Report (Shows count of members having attended at least once in the last month of the quarter.)
   - Districts (Breaks the members up into companionships)
   - Announcements

## Importing Data

Browser bookmarklet for copying home-teaching json from home teaching page.
Give inputs for members json and assignments json
When save button is pressed, old data is archived, not replaced (for historical reference).
