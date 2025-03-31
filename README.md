Job Portal Smart Contract
Successfully verified contract "contracts/jobPortal.sol:jobPortal" for network sepolia:
"https://sepolia.etherscan.io/address/0x814aC6D97D9fD96Eb8AA14Da3D2cdb4e462cDe1a#code"

The Job Portal Smart Contract is a decentralized platform that connects recruiters and job applicants on the Ethereum blockchain. This contract allows recruiters to post job listings and assign jobs to qualified applicants, while also enabling administrators to manage applicants and recruiters. Built with Solidity, the contract ensures security and trust through role-based access control and reentrancy protection.

Features
Admin Controls:

Add, remove, and manage recruiters.

Add and remove job applicants.

Transfer admin ownership.

Recruiter Features:

Post job listings.

Assign jobs to applicants.

Rate applicants.

Delete job postings.

Applicant Management:

Store applicant details, including skills, qualifications, and past labor history.

Maintain applicant availability status.

Assign ratings to applicants based on performance.

Security Measures:

ReentrancyGuard: Prevents reentrancy attacks.

OnlyAdmin & OnlyRecruiter Modifiers: Restricts access to sensitive functions.

Contract Functions
Admin Functions
transferAdmin(address newAdmin)
Transfers contract ownership to a new admin.

addRecruiter(address recruiter, string memory name, string memory qualification, string memory expertise)
Adds a recruiter with the given details.

removeRecruiter(address recruiter)
Removes a recruiter from the system.

addApplicant(uint8 applicantID, string memory name, uint8 age, string memory location, bool skilled, string memory skills, bool availability, string memory labourHistory, bool qualified)
Adds an applicant to the system.

deleteApplicant(uint8 applicantID)
Removes an applicant from the system.

Recruiter Functions
addJob(uint8 jobID, string memory location, string memory title, string memory description, uint256 remuneration)
Posts a job listing.

deleteJob(uint8 jobID)
Removes a job listing.

rateApplicant(uint8 applicantID, uint8 rating)
Assigns a rating (1-10) to an applicant.

assignJob(uint8 jobID, uint8 applicantID)
Assigns a job to a selected applicant.

View Functions
getRecruiterDetails(address recruiter)
Returns recruiter details.

getApplicantDetails(uint8 applicantID)
Returns applicant details.

getJobDetails(uint8 jobID)
Returns job details.

Verified Contract on Sepolia
This smart contract is deployed and verified on the Sepolia Testnet. You can view the contract details and interact with it on Etherscan:
Successfully verified contract "contracts/jobPortal.sol:jobPortal" for network sepolia:
"https://sepolia.etherscan.io/address/0x814aC6D97D9fD96Eb8AA14Da3D2cdb4e462cDe1a#code"
View JobPortal Contract on Sepolia Etherscan
