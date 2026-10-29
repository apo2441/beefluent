<?php
// inc/config.php
declare(strict_types=1);

/**
 * Set your Groq key in the GROQ_API_KEY environment variable.
 * Never commit a real key here.
 */
const GROQ_API_KEY = ""; // leave empty: set the GROQ_API_KEY environment variable instead

const GROQ_API_URL = "https://api.groq.com/openai/v1/chat/completions";
const GROQ_MODEL   = "llama-3.3-70b-versatile";
