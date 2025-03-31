// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract jobPortal is ReentrancyGuard {
    address public admin;

    struct Applicant {
        string name;
        uint8 age;
        string location;
        bool skilled;
        string skills;
        bool availability;
        string labourHistory;
        bool qualified;
        uint8 rating;
        bool exists;
    }

    struct Job {
        string location;
        string title;
        string description;
        uint256 remuneration;
        address provider;
        uint8 assignedApplicant;
        bool isFilled;
        bool exists;
    }

    struct Recruiter {
        string name;
        string qualification;
        string expertise;
        bool exists;
    }

    mapping(uint8 => Applicant) private applicants;
    mapping(uint8 => Job) private jobs;
    mapping(address => Recruiter) private recruiters;

    uint8 public applicantCount;
    uint8 public jobCount;

    event ApplicantAdded(uint8 applicantID, string name);
    event JobPosted(uint8 jobID, string title);
    event ApplicantRated(uint8 applicantID, uint8 rating);
    event JobAssigned(uint8 jobID, uint8 applicantID);
    event JobDeleted(uint8 jobID);
    event ApplicantDeleted(uint8 applicantID);
    event AdminTransferred(address newAdmin);
    event RecruiterAdded(address recruiter, string name, string qualification, string expertise);
    event RecruiterRemoved(address recruiter);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin is authorized");
        _;
    }

    modifier onlyRecruiter() {
        require(recruiters[msg.sender].exists, "Only verified recruiters can post jobs");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function transferAdmin(address newAdmin) public onlyAdmin {
        require(newAdmin != address(0), "Invalid address");
        admin = newAdmin;
        emit AdminTransferred(newAdmin);
    }

    function addRecruiter(address recruiter, string memory _name, string memory _qualification, string memory _expertise) public onlyAdmin {
        recruiters[recruiter] = Recruiter(_name, _qualification, _expertise, true);
        emit RecruiterAdded(recruiter, _name, _qualification, _expertise);
    }

    function removeRecruiter(address recruiter) public onlyAdmin {
        require(recruiters[recruiter].exists, "Recruiter does not exist");
        delete recruiters[recruiter];
        emit RecruiterRemoved(recruiter);
    }

    function getRecruiterDetails(address recruiter) external view returns (Recruiter memory) {
        require(recruiters[recruiter].exists, "Recruiter not found");
        return recruiters[recruiter];
    }

    function addApplicant(
        uint8 applicantID,
        string memory _name,
        uint8 _age,
        string memory _location,
        bool _skilled,
        string memory _skills,
        bool _availability,
        string memory _labourHistory,
        bool _qualified
    ) public onlyAdmin {
        require(!applicants[applicantID].exists, "Applicant already exists");
        applicants[applicantID] = Applicant(
            _name, _age, _location, _skilled, _skills, _availability, _labourHistory, _qualified, 0, true
        );
        applicantCount++;
        emit ApplicantAdded(applicantID, _name);
    }

    function deleteApplicant(uint8 applicantID) public onlyAdmin {
        require(applicants[applicantID].exists, "Applicant does not exist");
        delete applicants[applicantID];
        if (applicantCount > 0) {
            applicantCount--;
        }
        emit ApplicantDeleted(applicantID);
    }

    function getApplicantDetails(uint8 applicantID) public view returns (Applicant memory) {
        require(applicants[applicantID].exists, "Applicant not found");
        return applicants[applicantID];
    }

    function addJob(
        uint8 jobID,
        string memory _location,
        string memory _title,
        string memory _description,
        uint256 _remuneration
    ) public onlyRecruiter {
        require(!jobs[jobID].exists, "Job already exists");
        jobs[jobID] = Job(_location, _title, _description, _remuneration, msg.sender, 0, false, true);
        jobCount++;
        emit JobPosted(jobID, _title);
    }

    function deleteJob(uint8 jobID) public onlyRecruiter {
        require(jobs[jobID].exists, "Job does not exist");
        require(jobs[jobID].provider == msg.sender || msg.sender == admin, "Not authorized");
        delete jobs[jobID];
        if (jobCount > 0) {
            jobCount--;
        }
        emit JobDeleted(jobID);
    }

    function getJobDetails(uint8 jobID) public view returns (Job memory) {
        require(jobs[jobID].exists, "Job not found");
        return jobs[jobID];
    }

    function rateApplicant(uint8 applicantID, uint8 _rating) public onlyRecruiter {
        require(applicants[applicantID].exists, "Applicant not found");
        require(_rating <= 10, "Rating must be between 1 and 10");
        applicants[applicantID].rating = _rating;
        emit ApplicantRated(applicantID, _rating);
    }

    function assignJob(uint8 jobID, uint8 applicantID) public onlyRecruiter {
        require(jobs[jobID].exists, "Job does not exist");
        require(applicants[applicantID].exists, "Applicant does not exist");
        require(!jobs[jobID].isFilled, "Job is already filled");
        jobs[jobID].isFilled = true;
        jobs[jobID].assignedApplicant = applicantID;
        emit JobAssigned(jobID, applicantID);
    }
}
