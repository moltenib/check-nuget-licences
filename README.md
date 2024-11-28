# check-nuget-licences
A script to find out the licence of each NuGet package on a list.
Given a list of NuGet packages, look for their licences.
Creates a CSV file separated by tabs, with the columns:
`licence (or "check" if not found), URL (review if "check" was printed)`
