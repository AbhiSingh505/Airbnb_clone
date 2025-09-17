#!/bin/bash

# 🚀 Airbnb Clone - GitHub Setup Script
# This script helps you set up your GitHub repository

echo "🏠 Airbnb Clone - GitHub Setup Script"
echo "======================================"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "syGroupTask.xcodeproj/project.pbxproj" ]; then
    echo "❌ Please run this script from the project root directory."
    exit 1
fi

echo "✅ Project directory found"
echo ""

# Initialize git repository if not already initialized
if [ ! -d ".git" ]; then
    echo "🔧 Initializing Git repository..."
    git init
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

# Add all files
echo "📁 Adding files to Git..."
git add .

# Create initial commit
echo "💾 Creating initial commit..."
git commit -m "Initial commit: Airbnb Clone with SwiftUI

✨ Features:
- Custom animated tab bar with matched geometry effects
- Advanced search with voice recognition
- Interactive maps with property clustering
- Comprehensive property detail views
- Parallax scrolling and smooth animations
- Shimmer loading states
- MVVM architecture with SwiftUI
- Complete mock data system
- Modern iOS 17+ features

🎨 UI/UX:
- Professional animations and transitions
- Intuitive navigation and user flow
- Responsive design for all screen sizes
- Accessibility compliance
- Modern iOS design patterns

🛠️ Technical:
- Clean, maintainable code architecture
- Performance optimization
- Memory management
- Error handling
- Comprehensive documentation"

echo "✅ Initial commit created"
echo ""

# Get repository name from user
echo "📝 GitHub Repository Setup"
echo "=========================="
echo ""
echo "Please provide the following information:"
echo ""

read -p "GitHub username: " GITHUB_USERNAME
read -p "Repository name (default: airbnb-clone-swiftui): " REPO_NAME

# Set default repository name if empty
if [ -z "$REPO_NAME" ]; then
    REPO_NAME="airbnb-clone-swiftui"
fi

echo ""
echo "🔗 Repository URL: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo ""

# Add remote origin
echo "🔧 Adding remote origin..."
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# Set main branch
echo "🌿 Setting main branch..."
git branch -M main

echo ""
echo "📋 Next Steps:"
echo "=============="
echo ""
echo "1. Create a new repository on GitHub:"
echo "   - Go to https://github.com/new"
echo "   - Repository name: $REPO_NAME"
echo "   - Description: A comprehensive Airbnb clone built with SwiftUI featuring modern UI/UX patterns, advanced animations, and complete property booking experience"
echo "   - Make it public"
echo "   - Don't initialize with README (we already have one)"
echo "   - Don't add .gitignore (we already have one)"
echo "   - Add MIT License"
echo ""
echo "2. Push your code to GitHub:"
echo "   git push -u origin main"
echo ""
echo "3. Add repository topics:"
echo "   - swiftui"
echo "   - ios"
echo "   - airbnb-clone"
echo "   - mobile-app"
echo "   - swift"
echo "   - mvvm"
echo "   - mapkit"
echo "   - voice-search"
echo "   - animations"
echo "   - swiftui-animations"
echo ""
echo "4. Take screenshots:"
echo "   - Run the app in Xcode Simulator"
echo "   - Take screenshots of key screens"
echo "   - Save them in the screenshots/ directory"
echo "   - Update README.md with screenshot references"
echo ""
echo "5. Create a release:"
echo "   - Go to your repository on GitHub"
echo "   - Click 'Releases' → 'Create a new release'"
echo "   - Tag version: v1.0.0"
echo "   - Title: Airbnb Clone v1.0.0 - Initial Release"
echo "   - Add description from CHANGELOG.md"
echo ""
echo "🎉 Your project is ready for GitHub!"
echo ""
echo "📚 Documentation created:"
echo "  - README.md (comprehensive project overview)"
echo "  - CHANGELOG.md (detailed feature list)"
echo "  - CONTRIBUTING.md (contribution guidelines)"
echo "  - GITHUB_SETUP.md (setup instructions)"
echo "  - PROJECT_SUMMARY.md (technical summary)"
echo "  - screenshots/README.md (screenshot guide)"
echo "  - .gitignore (iOS project gitignore)"
echo "  - LICENSE (MIT license)"
echo ""
echo "🚀 Happy coding!"
